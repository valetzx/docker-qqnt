source ./config.sh

BUILD_AUTO_TAG=$(git rev-parse --abbrev-ref HEAD)-$(git rev-list --count HEAD)
BUILD_TAG=${BUILD_TAG:-${BUILD_AUTO_TAG}}
BUILD_DOCKER_BUILDER=${BUILD_DOCKER_BUILDER:-container}

echo "Building ilharp/qqnt:${BUILD_TAG} using builder: ${BUILD_DOCKER_BUILDER}\n\n"

BUILD_QQNT_DATA_VERSION_LATEST=${BUILD_QQNT_DATA_LIST%,*}

for BUILD_QQNT_DATA in ${BUILD_QQNT_DATA_LIST[@]};
do
  BUILD_QQNT_VERSION=${BUILD_QQNT_DATA%,*}
  BUILD_QQNT_LINK=${BUILD_QQNT_DATA#*,}

  BUILD_IMAGE_TAG=${BUILD_TAG}-linux-up${BUILD_QQNT_VERSION}

  for BUILD_ARCH in ${BUILD_ARCH_LIST[@]};
  do
    BUILD_PLATFORM=linux/${BUILD_ARCH}

    case $1 in
      "push")
        if [ "$BUILD_TAG" != "$BUILD_AUTO_TAG" -a $BUILD_QQNT_VERSION = $BUILD_QQNT_DATA_VERSION_LATEST ]
        then
          docker buildx build \
            --push \
            --builder=${BUILD_DOCKER_BUILDER} \
            --build-arg BUILD_QQNT_LINK=${BUILD_QQNT_LINK} \
            --build-arg BUILD_ARCH=${BUILD_ARCH} \
            --platform ${BUILD_PLATFORM} \
            -t ghcr.io/ilharp/docker-qqnt:${BUILD_IMAGE_TAG} \
            -t ghcr.io/ilharp/docker-qqnt:latest \
            -t ilharp/qqnt:${BUILD_IMAGE_TAG} \
            -t ilharp/qqnt:latest \
            .
        else
          docker buildx build \
            --push \
            --builder=${BUILD_DOCKER_BUILDER} \
            --build-arg BUILD_QQNT_LINK=${BUILD_QQNT_LINK} \
            --build-arg BUILD_ARCH=${BUILD_ARCH} \
            --platform ${BUILD_PLATFORM} \
            -t ghcr.io/ilharp/docker-qqnt:${BUILD_IMAGE_TAG} \
            -t ilharp/qqnt:${BUILD_IMAGE_TAG} \
            .
        fi
        ;;
      *)
        docker buildx build \
          --builder=${BUILD_DOCKER_BUILDER} \
          --build-arg BUILD_QQNT_LINK=${BUILD_QQNT_LINK} \
          --build-arg BUILD_ARCH=${BUILD_ARCH} \
          --platform ${BUILD_PLATFORM} \
          -t ghcr.io/ilharp/docker-qqnt:${BUILD_IMAGE_TAG} \
          -t ilharp/qqnt:${BUILD_IMAGE_TAG} \
          .
        ;;
    esac
  done
done
