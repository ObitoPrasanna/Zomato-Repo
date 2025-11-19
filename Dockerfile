#Stage 1: Build React App
FROM node:16-slim AS builder

WORKDIR /app
# Copy package files
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the rest of the app
COPY . .
# Build the React production build
RUN npm run build

# Stage 2: Serve Build with Node.js Server
FROM node:16-slim

WORKDIR /app
# Copy only the built React files from previous stage
COPY --from=builder /app/build ./build
# Install only production dependencies
COPY package*.json ./
RUN npm install --only=production
EXPOSE 3000
# Start your Node.js server
CMD ["npm", "start"]

