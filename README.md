# GARTH Assets

This repository is the asset and manifest channel for GARTH, the optional local automation assistant for Broadcaster FS.

It intentionally separates GARTH runtime assets from the main Broadcaster FS application repository.

What lives here:
- GARTH manifest files
- packaging scripts
- bootstrap installer metadata
- third-party notice files

What does **not** live here in git:
- large upstream model weight files
- local staging downloads
- generated GARTH bundle artifacts

Those artifacts are downloaded and packaged locally, then published separately when ready.

