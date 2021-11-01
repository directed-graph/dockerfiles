The `implementing/builder` image is meant for building my own projects and
therefore mainly includes only dependencies of my own projects.

General usage:

    # Build directly in project directory mapped to host.
    docker run --rm \
        --volume $(pwd):${PROJECT_DIR} \
        implementing/builder <build_command>

    # Build in a separate directory also mapped to host.
    tmpdir=$(mktemp -d)
    docker run --rm \
        --volume $(pwd):${PROJECT_DIR} \
        --volume ${tmpdir}:${BUILD_DIR} \
        --env USE_BUILD_DIR=yes \
        implementing/builder <build_command>

    # Build in a separate directory within container. This may be useful if
    # we only want stdout or if the results are written elsewhere.
    docker run --rm \
        --volume $(pwd):${PROJECT_DIR} \
        --env USE_BUILD_DIR=yes \
        implementing/builder <build_command>

If your user ID is not 1000, be sure to also set environment variables for
`BUILD_USER_ID` and/or `BUILD_GROUP_ID`. For example:

    --env BUILD_USER_ID=$(id -u) --env BUILD_GROUP_ID=$(id -g)

Note that this is not the same as `--user $(id -u)` or `--user $(whoami)`, as
we need something to satisfy the following two conditions:

1. Build is done as an actual user with a username (required for e.g. bazel).
2. Build is not done as root (required for e.g. makepkg).

In order to satisfy these two conditions, we will need a build user. Indeed,
the build user will need access to the `${PROJECT_DIR}`. So to do this, we will
create the user (`${BUILD_USER}`) with a floating user ID (`${BUILD_USER_UID}`)
and a floating group ID (`${BUILD_USER_GID}`).
