#!/usr/bin/env bash


# Abort on any error
set -e -u

# Simpler git usage, relative file paths
CWD=$(dirname "$0")
cd "$CWD"

# Load helpful functions
source libs/common.sh
source libs/docker.sh

# Check access to docker daemon
assert_dependency "docker"
if ! docker version &> /dev/null; then
	echo "Docker daemon is not running or you have unsufficient permissions!"
	exit -1
fi

IMG_NAME="hetsh/steamapi"
case "${1-}" in
	# Build and test with default configuration
	"--test")
		docker build \
			--tag "$IMG_NAME:test" \
			.
		docker run \
			--rm \
			--tty \
			--interactive \
			--mount type=bind,source=/etc/localtime,target=/etc/localtime,readonly \
			"$IMG_NAME:test" \
			steamcmd.sh \
			+login anonymous \
			+app_info_print 600760 \
			+quit | sed \
				-e '1,/600762/d' \
				-e '1,/manifests/d' \
				-e '/maxsize/,$d' | grep \
					--perl-regexp \
					--only 'public"\h+"\K\d+'
	;;
	# Build if it does not exist and push image to docker hub
	"--upload")
		if ! tag_exists "$IMG_NAME"; then
			docker build \
				--tag "$IMG_NAME:latest" \
				--tag "$IMG_NAME:$_NEXT_VERSION" \
				.
			docker push "$IMG_NAME:latest"
			docker push "$IMG_NAME:$_NEXT_VERSION"
			
			# Remove version for easier image cleanup
			docker image rm "$IMG_NAME:$_NEXT_VERSION"
		fi
	;;
	# Build image without additonal steps
	*)
		docker build \
			--tag "$IMG_NAME:latest" \
			.
	;;
esac
