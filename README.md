# monit
Here you can find a dockerfile which prepares an image to create monit containers from.
It you don't know what is monit, look here: https://mmonit.com/monit/

# Keep in mind
Because monit is running in its own container it is limited in its capabilities to observe processes of other container. But if you want to check remote accessability, it work quite fine.