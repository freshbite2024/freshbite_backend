# Use the official Ruby image as the base
FROM ruby:3.1.6

# Set the working directory
WORKDIR /app

# Copy the application files to the container
COPY . .

# Install dependencies
RUN gem install bundler && bundle install

# Expose the port your application will run on
EXPOSE 8080

# Command to run your application
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "8080"]
