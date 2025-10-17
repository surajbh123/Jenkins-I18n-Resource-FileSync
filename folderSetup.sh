#!/usr/bin/env bash
# WSL / Ubuntu-ready script to create i18n files for multiple owners and server types.
# Requires bash. Designed for WSL Ubuntu (or any Linux with bash).
set -euo pipefail

# Ensure we're running under bash (helps if someone runs "sh script" by mistake)
if [ -z "${BASH_VERSION:-}" ]; then
  echo "This script requires bash. Run it with: bash $0" >&2
  exit 1
fi

# Owners and server types
owners=(1120011 1120012 1120013 1120014 1120015)
servers=(prod preprod)

# languages to create inside each i18n folder
langs=(en eng fr)

for owner in "${owners[@]}"; do
  for srv in "${servers[@]}"; do
    dir="${owner}/staticResources/${srv}/resourcesBundle/i18n"
    mkdir -p "$dir"

    for lang in "${langs[@]}"; do
      file="${dir}/${lang}.properties"

      case "$lang" in
        en)
          content='invalidUserName=Invalid User Name'
          ;;
        eng)
          content='invalidUserName=Invalid User Name (ENG)'
          ;;
        fr)
          # UTF-8 friendly French text
          content="invalidUserName=Nom d'utilisateur invalide"
          ;;
        *)
          content='invalidUserName=Invalid User Name'
          ;;
      esac

      # Write/overwrite the properties file with the example line
      printf '%s\n' "$content" > "$file"
      # Make the file writable/executable/readable by everyone if you requested full perms
      chmod 777 "$file"
    done

    # Make the whole owner tree (including directories) world-accessible as requested
    chmod -R 777 "${owner}"
  done
done

echo "Done: created i18n files for owners: ${owners[*]} (servers: ${servers[*]}) with 777 permissions."