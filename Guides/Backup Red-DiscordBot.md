# Backup and restore Red-DiscordBot

- Take note of the installed cogs and cog repositories with [p]cogs, then [p]load downloader, then [p]repo list.
- Stop the bot, ideally with [p]shutdown.
- Run ```redbot-setup backup EPIC``` in your venv.
- Copy the backup file to the new machine/location.
- Extract the file to a location of your choice (remember the full path and make sure that the user you are going to install/run Red under can access this path).
- Install Red as normal on the new machine/location.
- Run ```redbot-setup``` to create a new instance, except use the path you remembered above as your data path.
- Start your new instance.
- Re-add the Repos using the same names as before.
- Do [p]cog update
- Re-add any cogs that were not re-installed (you may have to uninstall them first as Downloader may think they are still installed)
- Note: The config (data) from cogs has been saved, but not the code itself.
