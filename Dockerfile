# Use a minimal Node.js image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy only package.json and package-lock.json first (for better caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Ensure the environment variables are properly set
ARG NEXT_PUBLIC_ENVIRONMENT
ARG NEXT_PUBLIC_BASE_URL_PROD
ARG NEXT_PUBLIC_BASE_URL_DEV
ARG NEXT_PUBLIC_API_SECRET_KEY
ARG NEXT_PUBLIC_API_SECRET_IV
ARG NEXT_PUBLIC_API_ENCRYPTION_METHOD

ENV NEXT_PUBLIC_ENVIRONMENT=$NEXT_PUBLIC_ENVIRONMENT
ENV NEXT_PUBLIC_BASE_URL_PROD=$NEXT_PUBLIC_BASE_URL_PROD
ENV NEXT_PUBLIC_BASE_URL_DEV=$NEXT_PUBLIC_BASE_URL_DEV
ENV NEXT_PUBLIC_API_SECRET_KEY=$NEXT_PUBLIC_API_SECRET_KEY
ENV NEXT_PUBLIC_API_SECRET_IV=$NEXT_PUBLIC_API_SECRET_IV
ENV NEXT_PUBLIC_API_ENCRYPTION_METHOD=$NEXT_PUBLIC_API_ENCRYPTION_METHOD

# Run Tailwind build
RUN npm run build

# Expose necessary port (change if needed)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
