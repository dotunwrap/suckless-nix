PATCHES_DIR := "./patches"
SRC_DIR := "./src"
OUTPUT_DIR := "./src-patched"
BACKUP_DIR := "./bkp"

patch APP:
  #!/usr/bin/env bash
  set -e

  cd {{APP}}

  if [ ! -d "{{OUTPUT_DIR}}" ]; then
    echo "Generating {{OUTPUT_DIR}}..."
    mkdir -p {{OUTPUT_DIR}}
    cp {{SRC_DIR}}/* {{OUTPUT_DIR}}/ && chmod -R +w {{OUTPUT_DIR}}
    touch {{OUTPUT_DIR}}/patches-applied.txt
  else
    rm -f {{OUTPUT_DIR}}/*.rej
    rm -f {{OUTPUT_DIR}}/*.orig
  fi

  while IFS= read -r patch_file; do
    if grep -q "^$patch_file$" {{OUTPUT_DIR}}/patches-applied.txt; then
      echo "Warning: {{PATCHES_DIR}}/$patch_file already applied, skipping."
      continue
    fi

    if [ -f "patches/$patch_file" ]; then
      echo "Applying $patch_file..."
      echo $patch_file >> {{OUTPUT_DIR}}/patches-applied.txt
      patch -p1 -d {{OUTPUT_DIR}}/ < "{{PATCHES_DIR}}/$patch_file"
    else
      echo "Warning: {{PATCHES_DIR}}/$patch_file not found, skipping."
    fi
  done < {{PATCHES_DIR}}/patch-order.txt

  rm -f {{OUTPUT_DIR}}/*.rej
  rm -f {{OUTPUT_DIR}}/*.orig

  cp {{OUTPUT_DIR}}/config.def.h {{OUTPUT_DIR}}/config.def.h.orig

restart APP:
  cd {{APP}}

  mkdir -p {{BACKUP_DIR}}
  cp {{OUTPUT_DIR}}/config.def.h {{BACKUP_DIR}}
  rm -rf {{OUTPUT_DIR}}
  just patch
