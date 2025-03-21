#!/usr/bin/env sh

# Unpack linux build to get jars
echo "Unpacking product"
mkdir -p products/org.dataflowanalysis.product/target/deploy/DataFlowAnalysis
tar -xf products/org.dataflowanalysis.product/target/deploy/DataFlowAnalysis.linux.gtk.x86_64.tar.gz -C products/org.dataflowanalysis.product/target/deploy/DataFlowAnalysis
echo "Finished unpacking product"

# Rename jars to remove date of build (only name and version should be in the name)
echo "Renaming jars..."
for file in products/org.dataflowanalysis.product/target/deploy/DataFlowAnalysis/plugins/*.jar; do
  if [ -e "$file" ]; then
    newname=$(echo "$file" | sed -r 's|(.*)\_([0-9]+\.[0-9]+\.[0-9]+).*$|\1\2.jar|')
    mv "$file" "$newname"
  fi
done
echo "Finished renaming jars!"

# Pack the jars into an archive
echo "Repacking archive"
tar -cf products/org.dataflowanalysis.product/target/deploy/DataFlowAnalysis.jars.tar.gz products/org.dataflowanalysis.product/target/deploy/DataFlowAnalysis/plugins
echo "Repacked archive"

# Cleanup files
rm -rf products/org.dataflowanalysis.product/target/deploy/DataFlowAnalysis
