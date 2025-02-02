#!/bin/bash

# Function to find logs older than 7 days and send an email
send_log_email() {
    # Directory where logs are stored
    log_dir="/var/log"
    # Email recipient
    email_recipient="youremail@example.com"
    # Email subject
    subject="Logs Older Than 7 Days"
    # Temporary file to store the list of old log files
    temp_file="/tmp/old_logs.txt"
    
    # Find log files older than 7 days and save the list in a temporary file
    find $log_dir -name "*.log" -type f -mtime +7 > $temp_file
    
    # Check if any log files were found
    if [ -s $temp_file ]; then
        # If there are old logs, send an email with the list of files
        mailx -s "$subject" "$email_recipient" < $temp_file
        echo "Email sent with the list of old logs."
    else
        # If no old logs are found, send an email stating no old logs
        echo "No logs older than 7 days found." | mailx -s "$subject" "$email_recipient"
        echo "No old logs found. Email sent."
    fi

    # Clean up temporary file
    rm -f $temp_file
}

# Call the function to check logs and send email
send_log_email
