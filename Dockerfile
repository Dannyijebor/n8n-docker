FROM n8nio/n8n:latest

# Set working directory
WORKDIR /home/node

# Expose the n8n port (Render defaults to 10000)
ENV N8N_PORT=10000
EXPOSE 10000

# Explicitly define the startup command to bypass entrypoint issues
ENTRYPOINT ["n8n"]
CMD ["start"]