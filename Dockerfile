#Dockerfile
# Use the official Ruby image as the base
FROM ruby:3.1.6

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock first for dependency installation
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN gem install bundler && bundle install

# Copy the rest of the application files
COPY . .

# Expose the port your application will run on
EXPOSE 8080

# Command to run your application
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "8080"]
