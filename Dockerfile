FROM ubuntu:trusty

# Install packages for building ruby
RUN apt-get update
RUN apt-get install -y --force-yes build-essential wget git sqlite3
RUN apt-get clean

# Use an official Ruby runtime as a parent image
FROM ruby 

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed gem 
RUN gem install sinatra
RUN gem install sqlite3

# Make port 80 available to the world outside this container
EXPOSE 80 

