# Use the official Node.js image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy your app.js file into the container
COPY app.js .

# Run the app.js file using the Node.js interpreter
CMD ["node", "app.js"]
