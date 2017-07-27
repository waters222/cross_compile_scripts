
OSX_DEPLOYMENT_TARGET="10.12"
OPENSSL_VERSION="openssl-1.1.0f"
buildMac()
{
	ARCH=$1

	echo "Building ${OPENSSL_VERSION} for ${ARCH}"

	TARGET="darwin64-x86_64-cc"

	export CC="${BUILD_TOOLS}/usr/bin/clang -mmacosx-version-min=${OSX_DEPLOYMENT_TARGET}"

	cd "${OPENSSL_VERSION}"
	./Configure no-asm ${TARGET}
	make
}


if [ ! -e ${OPENSSL_VERSION}.tar.gz ]; then
	echo "Downloading ${OPENSSL_VERSION}.tar.gz"
	curl -O https://www.openssl.org/source/${OPENSSL_VERSION}.tar.gz
else
	echo "Using ${OPENSSL_VERSION}.tar.gz"
fi

echo "Unpacking openssl"
tar xfz "${OPENSSL_VERSION}.tar.gz"

buildMac "x86_64"

echo "Building Mac libraries"

echo "Done"