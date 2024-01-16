#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title View in activities
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description View the activitiy logs from the object being viewed
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse

# Function to extract the last string after the last slash
getLastStringAfterSlash() {
  url="$1"
  last_string=$(echo "$url" | awk -F/ '{print $NF}')
  echo "$last_string"
}

# Function to modify the last string between the last two slashes
modifyLastString() {
  last_string="$1"
  # Convert hyphen-separated string to camel-case format
  last_string=$(echo "$last_string" | awk -F- '{for (i=1; i<=NF; ++i) printf "%s%s", toupper(substr($i,1,1)), tolower(substr($i,2)); printf "\n"}' | sed 's/s$//')
  echo "$last_string"
}

# Function to modify the last string between the last two slashes
modifySubscriptionString() {
  last_string="$1"
  if [ "$last_string" = "Subscription" ]; then
    last_string="Subscriptions::$last_string"
  elif [ "$last_string" = "User" ]; then
    last_string="Customer"
  fi
  echo "$last_string"
}

# Function to extract the last string between the last two slashes
getLastStringBetweenSlashes() {
  url="$1"
  last_string=$(echo "$url" | awk -F/ '{print $(NF-1)}')
  last_string=$(modifyLastString "$last_string")
  last_string=$(modifySubscriptionString "$last_string")
  echo "$last_string"
}

# Function to get the date six months ago
getSixMonthsAgoDate() {
  date -v -6m "+%Y-%m-%d"
}

# Get the URL of the active tab in Google Chrome and copy it to the clipboard
osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' | pbcopy

url=$(pbpaste)

# Extract the last strings from the URL
last_string_after_slash=$(getLastStringAfterSlash "$url")
last_string_between_slashes=$(getLastStringBetweenSlashes "$url")
date_six_months_ago=$(getSixMonthsAgoDate)
date_six_months_ago=$(echo "$date_six_months_ago"$echo"TOO")


open "https://www.indigoshoprx.co.uk/en-GB/activities?q%5Bcreated_at_gteq%5D=$date_six_months_ago%3A00%3A34&q%5Bcreated_at_lteq%5D=&q%5Brequest_id_eq%5D=&q%5Baudited_changes%5D=&q%5Bclient_id_eq%5D=&q%5Bwhodunnit_cont%5D=&q%5Bitem_subtype_eq%5D=$last_string_between_slashes&q%5Bitem_id_eq%5D=$last_string_after_slash&button="
