#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
DRIVER_VERSION=9.3.0
DRIVER_JAR="lib/mysql-connector-j-$DRIVER_VERSION.jar"
mkdir -p lib out
if [ ! -f "$DRIVER_JAR" ]; then
  echo "Downloading MySQL Connector/J $DRIVER_VERSION..."
  if command -v curl >/dev/null 2>&1; then
    curl -fL "https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/$DRIVER_VERSION/mysql-connector-j-$DRIVER_VERSION.jar" -o "$DRIVER_JAR"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$DRIVER_JAR" "https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/$DRIVER_VERSION/mysql-connector-j-$DRIVER_VERSION.jar"
  else
    echo "curl or wget is required to download MySQL Connector/J." >&2; exit 1
  fi
fi
javac -encoding UTF-8 -cp "$DRIVER_JAR" -d out src/main/java/StudentRecordApp.java
java -cp "out:$DRIVER_JAR" StudentRecordApp
