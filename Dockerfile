# Use an official Python runtime as a parent image
FROM ruby:2.4

# Install any needed packages
RUN apt-get update && \
									    apt-get install -y \
											build-essential \
											nodejs \
											texlive \
											texlive-metapost \
											fontforge \
											lcdf-typetools \
											t1utils \
											python-fontforge \
											python-argparse \
                      vim \
                      mysql-client \
											libmysqlclient-dev \
											mysql-common \
                      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages
RUN gem install bundler
RUN bundle install

# Make port 9292 available to the world outside this container
EXPOSE 100
