#!/bin/sh

export VERSION=1.10.0-rc.3
export FILE=smm_${VERSION}_darwin_all.tar.gz

echo "Getting SMM Version: ${VERSION}"
aws s3 cp s3://cisco-eti-banzai-binaries/smm-cli/${VERSION}/dist/${FILE} ~/smm_versions/

echo "Untarring..."
tar mxvf ~/smm_versions/${FILE} -C ~/smm_versions/
rm ~/smm_versions/${FILE}

echo "Renamed.. to ~/smm_versions/smm_${VERSION}"
mv ~/smm_versions/smm ~/smm_versions/smm_${VERSION}
