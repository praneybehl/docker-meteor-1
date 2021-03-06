# DOCKER-VERSION 1.8.1
# METEOR-VERSION 1.2.1
FROM debian:jessie

RUN apt-get update

# Install git, curl, python, and phantomjs
#RUN apt-get install -y git curl python phantomjs
RUN apt-get install -y git curl python

# Install latest Node from nodesource
RUN curl https://deb.nodesource.com/setup | sh
RUN apt-get install -y nodejs

# Make sure we have a directory for the application
RUN mkdir -p /var/www
RUN chown -R www-data:www-data /var/www

# Install fibers -- this doesn't seem to do any good, for some reason
RUN npm install -g fibers

# Install Meteor
RUN curl https://install.meteor.com/ |sh

# Install entrypoint
ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Add known_hosts file
ADD known_hosts /root/.ssh/known_hosts

EXPOSE 80

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD []
