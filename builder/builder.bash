#!/usr/bin/env bash

set -o nounset -o errexit

is_dir_and_can_access() {
  test -r "${1}" && \
  test -w "${1}" && \
  test -x "${1}" && \
  test -d "${1}"
}

if (( "${EUID:-$(id -u)}" == 0 )); then
  groupadd -g ${BUILD_USER_GID} "${BUILD_USER}" || true
  useradd -m -u "${BUILD_USER_UID}" -g "${BUILD_USER_GID}" "${BUILD_USER}"
  sudo --set-home --preserve-env -u "${BUILD_USER}" "${0}" "${@}"
else
  if ! is_dir_and_can_access "${PROJECT_DIR}"; then
    >&2 echo \
        "Unable to access ${PROJECT_DIR}." \
        "Did you pass in --volume \$(pwd):${PROJECT_DIR}?" \
        'Or do you need to use --env BUILD_USER_UID=$(id -u)?'
    exit 1
  fi
  cd "${PROJECT_DIR}"

  if [[ "${USE_BUILD_DIR}" == "yes" ]]; then
    >&2 echo "\$USE_BUILD_DIR is set; using ${BUILD_DIR}."

    if ! is_dir_and_can_access "${BUILD_DIR}"; then
      >&2 echo \
          "Unable to access ${BUILD_DIR}." \
          "Using container tmpdir instead." \
          "Use --volume \${host_tmpdir}:${BUILD_DIR} to map to host instead."
      BUILD_DIR=$(mktemp -d)
    fi

    rsync -a "${PROJECT_DIR}/" "${BUILD_DIR}"
    cd "${BUILD_DIR}"
  fi

  "${@}"
fi
