#!/bin/sh

#  BuildNumberDebug.sh
#  JYXTeacher
#
#  Created by YXG on 2018/8/16.
#  Copyright © 2018年 JYXTeacher. All rights reserved.

set -e

DATE=$(date '+%y%m%d%H%M')

BuildTimes=$(/usr/libexec/PlistBuddy -c "Print BuildTimes" "$INFOPLIST_FILE")
shortVersion=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$INFOPLIST_FILE")
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$INFOPLIST_FILE")


if [ "$CONFIGURATION" == "Release" ]; then

BuildTimes="$DATE"
/usr/libexec/PlistBuddy -c "Set :BuildTimes $BuildTimes" "$INFOPLIST_FILE"


buildNumber="$shortVersion.$BuildTimes"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$INFOPLIST_FILE"

fi
