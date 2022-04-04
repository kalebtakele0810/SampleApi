set -e
set -x


java $JAVA_OPTS -server -Dspring.profiles.active=${SPRING_PROFILES_ACTIVE} -jar paga-partner-portal.jar
