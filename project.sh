#! /bin/bash

# Project - Simple project management for Linux developers.
# Use:
# IMPLEMENTED
# project start: start a new project in the project management system.
# project pickup: show the log file up to this point
# project list: show current projects and last log entries.
# project checkpoint: create a new log entry and commit to git.
# project import: add an existing project to the database.

# TODO:
# project progress: show completion status of current project
# project clockin: start clocking hours worked on the current project.
# project clockout: stop clocking hours.

PROJECTS_DIR=$HOME/dev
CONFIG_DIR=$HOME/.projects

DATE=$(date +"%A, %B %d %Y %X")
LOG_HEADER="$DATE \n$USER"
LOG_MESSAGE="Enter your log entry directly below, and do not delete this line."
README_EXAMPLE="This is a README file."

# Prints the usage statement.
# Arguments: None.
usage(){
    echo "Usage: project < start | pickup | checkpoint | list | import | delete >"
}

# TOP LEVEL FUNCTIONS

# Starts a new project, and prompts the user for required information.
# Arguments: None.
start_project(){
    check_database
    echo -n "Name for the project? "
    read PROJECT_NAME
    DIRNAME=$(clean_dirnames "$PROJECT_NAME")

    # Create project directory
    PROJECT_DIR=$PROJECTS_DIR/$DIRNAME
    mkdir -p $PROJECT_DIR
    cd $PROJECT_DIR

    # Initialize log, README, git repo
    echo -e "$LOG_HEADER\nInitialized project." >> log
    echo -e $README_EXAMPLE >> README
    echo -e "Project: $PROJECT_NAME" >> .project
    echo -e "User: $USER" >> .project
    echo "Quick description: "
    read DESCRIPTION
    echo -e "Description: $DESCRIPTION" >> .project
    git init
    git add log README .project

    # Add project to SQLITE database
    sqlite3 -line $CONFIG_DIR/projects.db \
        "insert into projects values ('$PROJECT_NAME', '$PROJECT_DIR');"
}

# Import an existing directory tree into the project database.
# Arguments: None
import_project(){
    check_database
    echo -n "What is the top level directory of the project? "
    PROJECT_DIR=""
    while [ ! -d "$PROJECT_DIR" ]; do
        read PROJECT_DIR
        if [ ! -d "$PROJECT_DIR" ]; then
            echo -n "That's not a directory, or it doesn't exist. Try again: "
        fi
    done

    cd $PROJECT_DIR    
    echo -n "What do you want to call the project? "
    read PROJECT_NAME
    echo "Quick description:"
    read DESCRIPTION

    if [ ! -d .git ]; then
        echo "There's no .git directory here, creating git repository."
        git init
    fi

    if [ -e .project ]; then
        echo "There's already a project file here, I'm moving it to .project.bak."
        mv .project .project.bak
    fi

    echo -e "Project: $PROJECT_NAME" >> .project
    echo -e "User: $USER" >> .project
    echo -e "Description: $DESCRIPTION" >> .project

    echo -e "$LOG_HEADER\nImported directory tree into new project." >> log
    git add log .project

    if [ ! -e README ]; then
        echo "Creating README file..."
        echo "$README_EXAMPLE" >> README
        git add README
    fi

    # Add project to SQLITE database
    sqlite3 -line $CONFIG_DIR/projects.db \
        "insert into projects values ('$PROJECT_NAME', '$(pwd)');"
    echo "Done importing. Now might be a good time to make a git commit."
}

# These next two functions have a lot of repeated code, but I don't quite know
# how to factor it out since it's interactive and needs to return a value.
# Dammit, bash...

# Allows the user to select a project from a list and then moves to that
# project's directory and prints the last log message.
# Arguments: None.
pickup_project(){
    check_database

    # List projects and ask which to open
    PROJECTS=$(sqlite3 -list $CONFIG_DIR/projects.db "select name from projects;")
    NUM_PROJECTS=-1

    OLD_FS=$IFS
    IFS=$'\n'
    for PROJECT_NAME in $PROJECTS; do
        let NUM_PROJECTS++
        PROJ_ARRAY[$NUM_PROJECTS]=$PROJECT_NAME
        echo "$NUM_PROJECTS: $PROJECT_NAME"
    done
    echo -n "Select a project: "
    read PROJECT_SELECTION
    IFS=$OLD_FS    

    # Bounds check.
    if [ \( $PROJECT_SELECTION -gt $NUM_PROJECTS \) -o \( $PROJECT_SELECTION -lt 0 \) ]; then
        echo "Invalid selection."
        exit 1
    fi
    
    # Get project name from array
    PROJECT_SELECTION=${PROJ_ARRAY[$PROJECT_SELECTION]}

    PROJECT_ROW=$(sqlite3 -separator : -list $CONFIG_DIR/projects.db \
        "select * from projects where name='$PROJECT_SELECTION'")

    describe_project "$PROJECT_ROW"

    # Switch to the project directory
    PROJECT_DIR=$(echo "$PROJECT_ROW" | awk -F: '{ print $2 }')
    cd $PROJECT_DIR # This won't work unless you have the right alias set up.
}

# Delete project from the database.
# Arguments: None.
delete_project(){
    # List projects and ask which to open
    PROJECTS=$(sqlite3 -list $CONFIG_DIR/projects.db "select name from projects;")
    NUM_PROJECTS=-1

    OLD_FS=$IFS
    IFS=$'\n'
    for PROJECT_NAME in $PROJECTS; do
        let NUM_PROJECTS++
        PROJ_ARRAY[$NUM_PROJECTS]=$PROJECT_NAME
        echo "$NUM_PROJECTS: $PROJECT_NAME"
    done
    echo -n "Select a project: "
    read PROJECT_SELECTION
    IFS=$OLD_FS    

    # Bounds check.
    if [ \( $PROJECT_SELECTION -gt $NUM_PROJECTS \) -o \( $PROJECT_SELECTION -lt 0 \) ]; then
        echo "Invalid selection."
        exit 1
    fi
    
    # Get project name from array
    PROJECT_SELECTION=${PROJ_ARRAY[$PROJECT_SELECTION]}

    sqlite3 $CONFIG_DIR/projects.db "delete from projects where name='$PROJECT_SELECTION'"
}

# Creates a log entry for the current project, and enables the user to commit
# to the git repository.
# Arguments: None.
checkpoint_project(){
    check_database
    # Bring up new editor window with temporary file, prepopulate with log data
    # like the date, user's name, etc.
    PROJECT_DIR=$(find_project)
    if [ ! -n "$PROJECT_DIR" ]; then
        echo "It doesn't look like you're in a project directory."
        echo "Try using 'project pickup' to open a project, or "
        echo "use 'project import' to make a new project here."
    else
        touch /tmp/project-$$ # Temp file is project-<PID>
        echo -e $LOG_MESSAGE >> /tmp/project-$$
        $EDITOR /tmp/project-$$

        # Ask if the user wants to commit to git repo
        echo "Current git status:"
        git status
        echo "Commit to git repository? If you forgot to add anything, decline and do it manually. [y/N]"
        read COMMIT_REQUESTED
        echo -e "$LOG_HEADER" >> $PROJECT_DIR/log
        if [ "$COMMIT_REQUESTED" == 'y' -o "$COMMIT_REQUESTED" == 'Y' ]; then
            COMMIT_NUM=$(git commit -m "$(cat /tmp/project-$$)" | grep '\[.*\]')
            echo -e "$COMMIT_NUM\n" >> $PROJECT_DIR/log
        fi
        echo -e "$(cat /tmp/project-$$ | tail -n +2)\n" >> $PROJECT_DIR/log
        rm /tmp/project-$$
    fi
}

# Show a list of all the projects, and their descriptions.
# Arguments: None.
list_projects(){
    check_database
    # Query SQLITE and show currently available projects, and the last update
    PROJECTS=$(sqlite3 -separator ":" -list $CONFIG_DIR/projects.db  "select * from projects;")
    if [ ! -n "$PROJECTS" ]; then
        echo "No projects found. Why don't you create one?"
    else
        OLD_FS=$IFS
        IFS=$'\n'
        for ROW in $PROJECTS; do
            describe_project "$ROW"
        done
        IFS=$OLD_FS
    fi
}

# UTILITY FUNCTIONS

# Select a project from a list of projects and print its SQLITE row.
# Arguments: None.
# Prints: The SQLITE row for the project, with : as the separator.
select_project(){

    echo "$PROJECT_ROW"
}

# Locates the top level directory of the current project.
# Arguments: None.
# Prints: The top-level directory.
find_project(){
    # Move up in the directory tree until either a project 
    # is found or we reach root.
    while [ ! -e ./.project -a $PWD != "/" ]; do
        cd ../
    done
    if [ "$PWD" != "/" ]; then
        echo "$PWD"
    else
        echo "Could not find project in current directory's supertree." >&2
    fi
}

# Describes a given project. 
# Arguments: the SQLITE row for the project, : separated.
describe_project(){
    # Cut out the two fields from the database row: name and directory
    DIRECTORY=$(echo "$1" | awk -F: '{ print $2 }')
    PROJECT_NAME=$(echo "$1" | awk -F: '{ print $1 }')
    DESCRIPTION=$(grep -P -o '(?<=Description: ).*' $DIRECTORY/.project)
    LAST_UPDATE=$(grep "[0-9][0-9]:[0-9][0-9]:[0-9][0-9] \(AM\|PM\)" $DIRECTORY/log | tail -n 1)
    LAST_LOG=$(grep -A2 "$LAST_UPDATE" $DIRECTORY/log | tail -n 1)
    echo "Project:      $PROJECT_NAME"
    echo "Description:  $DESCRIPTION"
    echo "Last Updated: $LAST_UPDATE"
    echo "$LAST_LOG"
    echo
}

# Checks to see that the database exists.
# Arguments: None.
check_database(){
    # Check to see if the database exists, and if not create it.
    if [ ! -e $CONFIG_DIR/projects.db ]; then
        echo "Creating new database file in $CONFIG_DIR."
        mkdir -p $CONFIG_DIR
        sqlite3 -line $CONFIG_DIR/projects.db \
            "create table projects(name varchar(25), directory varchar(200));"
    fi
    # Check to make sure we have a valid table to work with.
    if [ ! -n $(sqlite3 -line $CONFIG_DIR/projects.db ".tables") ]; then
        echo "No tables in database, creating one."
        sqlite3 -line $CONFIG_DIR/projects.db \
            "create table projects(name varchar(25), directory varchar(200));"
    fi
}

# Trims whitespace off the argument.
# Arguments: A string to be trimmed.
# Prints: The string without left and right whitespace.
trim(){
    echo $1
}

# Cleans directory names by removing bad punctuation and whitespace and 
# lowercasing the name.
# Arguments: A string to be cleaned.
clean_dirnames(){
    DIRNAME=$(trim $1)
    DIRNAME=$(echo "$DIRNAME" | tr ' \t\v' '-' | tr -d '\n\r/,!<>;:#\$^&*()\\' | \
        tr '[:upper:]' '[:lower:]')
    echo $DIRNAME
}

if [ $# != 1 ]; then
    usage
else
    case "$1" in 
        start) 
            start_project ;;
        pickup)
            pickup_project ;;
        checkpoint)
            checkpoint_project ;;
        list)
            list_projects ;;
        import)
            import_project ;;
        delete)
           delete_project ;;
        *)
            echo "Invalid argument '$1'." ;;
    esac
fi