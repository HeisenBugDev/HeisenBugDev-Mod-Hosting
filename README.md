HeisenBugDev Website
====================

This is the website repo for HeisenBugDev.

## Design specs

### API
The API is the holy grail of this. Everything goes through the API. Don't try to get rid of the API! API API API API API. Anyway...

Here's a couple use cases:

Build completes, API is sent the artifacts and a JSON (yay, not XML) file containing the info about the build. More info on that later. File is then uploaded to an external storage place (AWS?). The API also sends info to the Rasterizer and Article Builder telling it that it needs to run.

### Rasterizer
The rasterizer will take the block textures and do some image magicals to make 3d blocks out of them so that we can automatically update pictures of the blocks on le wiki.

### Article Builder
Some blocks share traits which will be auto detected by analyzing the code and then providing info about each block to the API.

### Storage Module
The storage module is in charge of... well... storing stuff. When it is sent a file, it will automatically compare it with the previous file from the last build (info on why later). If it is different, it will store it as a new entry. The .jar files and build info will _always_ be saved as a new entry. The other files such as ones from the Article Builder and Rasterizer will follow the save if changed policy.

### w3 site
The www site is all the static pages.

### Wiki
The wiki page takes advantage of storing all past iterations of documention (rasterizer, article builder). This is the use case:

Say you are a user with v1 of QuantumCraft (v2 is latest). There has been a new feature added in a newer update but you are stuck on the old version. Most wikis don't easily say when feature x was added or give you a page for a specific version of the said mod. The wiki will be able to provide you options to switch the version of the mod to the version you are running so you are not confused to why feature x is not working.

#### Articles
Even though a lot of the articles can be automatically built, you can't automate it all. (NOT DONE!)

### Downloads
Um... how do I describe this? Downloads anyone?