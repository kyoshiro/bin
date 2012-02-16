#!/bin/sh

# Rebuild dependencies
echo "Step 1/4: Fixing dependencies (revdep-rebuild)."
revdep-rebuild || (echo "Step 1/4: Error while fixing dependencies."; exit 1)
echo "Step 1/4: Finished dependencies check/fixing."

# fix la files
echo "Step 2/4: Fixing lafiles (lafilefixer)."
lafilefixer || (echo "Step 2/4: Error while fixing lafiles."; exit 1)
echo "Step 2/4: Finished lafile fixing."

# fix python linkage
echo "Step 3/4: Fixing python linkage (python-updater)."
python-updater || (echo "Step 3/4: Error while fixing python modules."; exit 1)
echo "Step 3/4: finished python linkage checking/fixing."

# fix perl linkage
echo "Step 4/4: Fxing perl linkage (perl-cleaner)."
perl-cleaner --modules || (echo "Step 4/4: Error while fixing perl modules."; exit 1)
echo "Step 4/4: Finished perl linkage checking/ficing."
