-- Remove the existing dashboard images
-- This works by removing everything under the "Last Import" menu so you ened to do at least one import before the dashboards
-- Reason being, the appleTV will revert to nature images if you empty the album entirely

-- NOTE: if running from the command line, you MUST all Terminal under Security & Privacy->Privacy

tell application "Photos" to activate

tell application "System Events" to tell process "Photos"
	-- name of every menu of menu bar 1
	-- name of every menu item of menu 1 of menu bar item "File" of menu bar 1
	
	repeat until enabled of menu item "New Album…" of menu 1 of menu bar item "File" of menu bar 1
	end repeat
	
	if exists menu item "Show Sidebar" of menu 1 of menu bar item "View" of menu bar 1 then
		keystroke "s" using {option down, command down} -- Show sidebar
	end if
	
	select (row 1 of outline 1 of scroll area 1 of group 2 of splitter group 1 of window 1 whose value of static text 1 of UI element 1 is "Last Import")
	repeat until enabled of menu item "Select All" of menu 1 of menu bar item "Edit" of menu bar 1
	end repeat
	
	keystroke "a" using {command down} -- select all photos in the album
	delay 1
	key code 51 using {command down}
end tell

-- Handle importing the new photos
set importFolder to "untitled:Users:devops:Documents:screenshots"
set extensionsList to {"jpg", "png"}

tell application "Finder"
	set fileList to every file of folder importFolder whose name extension is in extensionsList
end tell

if (count of fileList) < 1 then
	log "No images to import"
else
	set albumName to "dashboards"
	set imageList to {}
	
	repeat with i from 1 to number of items in fileList
		set this_item to item i of fileList as alias
		set the end of imageList to this_item
	end repeat
	
	tell application "Photos"
		
		activate
		delay 2
		
		import imageList into (album named albumName) skip check duplicates yes
		
	end tell
	
end if

