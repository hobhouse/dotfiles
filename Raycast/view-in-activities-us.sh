#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title View in activities - US
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description View the activity logs from the object being viewed - US
# @raycast.author Jack Hobhouse
# @raycast.authorURL https://github.com/hobhouse




# Function to extract the last string after the last slash
getLastStringAfterSlash() {
  url="$1"
  last_string=$(echo "$url" | awk -F/ '{print $NF}')
  echo "$last_string"
}

# Function to modify the last string between the last two slashes
convertToCamelCase() {
  string="$1"
  # Check if the input matches any of the strings
  if [[ $string == "sepa" || $string == "bacs" || $string == "cms" ]]; then
      # Convert the string to uppercase
      string=$(echo "$string" | tr '[:lower:][:upper:]' '[:upper:][:upper:]')
  else
      string=$(echo "$string" | awk -F- '{for (I=1; I<=NF; ++I) printf "%s%s", toupper(substr($I,1,1)), tolower(substr($I,2)); printf "\n"}' | sed 's/Faq/FAQ/' | sed 's/ies$/y/' | sed 's/ses$//;s/s$//')
  fi

  # Convert hyphen-separated string to camel-case format
  echo "$string"
}

# Function to modify the last string between the last two slashes
findModelName() {
  last_string="$1"
  second_last_string="$2"

  # Check if the second to last string is a locale
  if [ "$second_last_string" != "en-GB" ] && [ "$second_last_string" != "en-US" ] && [ "$second_last_string" != "nl" ]; then
      model_name="$(convertToCamelCase "$second_last_string")::$last_string"
  else
      model_name="$last_string"
  fi

  if [ "$model_name" = "User" ]; then
    model_name="Customer"
  elif  [ "$model_name" = "Subscription" ]; then
    model_name="Subscriptions::$last_string"
  fi
  echo "$model_name"
}


#   fi

#   if [ "$last_string" = "Subscription" ]; then
#     last_string="Subscriptions::$last_string"
#   elif [ "$last_string" = "User" ]; then
#     last_string="Customer"
#   fi
#   echo "$last_string"
# }

# Function to extract the last string between the last two slashes
getLastStringBetweenSlashes() {
  url="$1"
  last_string=$(echo "$url" | awk -F/ '{print $(NF-1)}')
  second_last_string=$(echo "$url" | awk -F/ '{print $(NF-2)}')
  last_string=$(convertToCamelCase "$last_string")
  model_name=$(findModelName "$last_string" "$second_last_string")
  echo "$model_name"
}

getSecondLastStringBetweenSlashes() {
  url="$1"
  last_string=$(echo "$url" | awk -F/ '{print $(NF-2)}')
  last_string=$(convertToCamelCase "$last_string")
  last_string=$(modifySubscriptionString "$last_string")
  echo "$last_string"
}

# Function to get the date six months ago
getSixMonthsAgoDate() {
  date -v -6m "+%Y-%m-%d"
}

# Get the URL of the active tab in Google Chrome and copy it to the clipboard
osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' | pbcopy

url=$(pbpaste | sed 's/\/edit//g')

# Extract the last strings from the URL
last_string_after_slash=$(getLastStringAfterSlash "$url")
last_string_between_slashes=$(getLastStringBetweenSlashes "$url")
date_six_months_ago=$(getSixMonthsAgoDate)
date_six_months_ago=$(echo "$date_six_months_ago"$echo"TOO")

open "https://www.indigoshoprx.com/en-GB/activities?q%5Bcreated_at_gteq%5D=$date_six_months_ago%3A00%3A34&q%5Bcreated_at_lteq%5D=&q%5Brequest_id_eq%5D=&q%5Baudited_changes%5D=&q%5Bclient_id_eq%5D=&q%5Bwhodunnit_cont%5D=&q%5Bitem_subtype_eq%5D=$last_string_between_slashes&q%5Bitem_id_eq%5D=$last_string_after_slash&button="
