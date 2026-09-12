#!/bin/bash

BUCKET=demobucket678595

echo "Deleting all object versions..."

objects=$(aws s3api list-object-versions --bucket "$BUCKET" --query "Versions[].[Key,VersionId]" --output text)
if [ -z "$objects" ] || [ "$objects" = "None" ]; then
    echo "No object versions found in the bucket."
else
    echo "$objects" | while IFS=$'\t' read -r key version_id; do
        echo "Deleting object version: $key -> version: $version_id"
        version_id=${version_id%$'\r'}
        aws s3api delete-object --bucket "$BUCKET" --key "$key" --version-id "$version_id"
    done
fi

delete_markers=$(aws s3api list-object-versions --bucket "$BUCKET" --query "DeleteMarkers[].[Key,VersionId]" --output text)
if [ -z "$delete_markers" ] || [ "$delete_markers" = "None" ]; then
    echo "No delete markers found in the bucket."
    exit 1
else
    echo "$delete_markers" | while IFS=$'\t' read -r key version_id; do
        echo "Deleting delete marker: $key -> version: $version_id"
        version_id=${version_id%$'\r'}
        echo "$version_id $key"
        aws s3api delete-object --bucket "$BUCKET" --key "$key" --version-id "$version_id"
    done
fi

echo "Deleting the bucket..."
aws s3api delete-bucket --bucket "$BUCKET"

echo "Bucket deleted sucessfully."

#echo -n "$version_id" | od -An -tx1 #octal dump in finding \r carriage return in version_id.
#[ "$objects" = "None" ] ignores files with no versions/delete markers to avoid InvalidArgument(Version id cannot be the empty) error.
#IFS used in deleting the files with spaces in their names.