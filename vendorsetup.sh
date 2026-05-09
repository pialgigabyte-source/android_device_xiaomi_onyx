#!/bin/bash

# Color and Formatting Variables
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
CYAN="\033[0;36m"
BWHITE="\033[1;37m"
BGREEN="\033[1;32m"
BYELLOW="\033[1;33m"
BRED="\033[1;31m"

# Counters Initialization
SKIPPED_COUNT=0
CLONED_COUNT=0
FAILED=0

# Horizontal Rule Function
hr() {
    local COLOR="$1"
    echo -e "${COLOR}──────────────────────────────────────────────────────────────────────${RESET}"
}

# POCO F7 Logo & Author Info
clear
echo -e "${CYAN}"
cat << "EOF"
 ██████╗  ██████╗  ██████╗ ██████╗    ███████╗███████╗
 ██╔══██╗██╔═══██╗██╔════╝██╔═══██╗   ██╔════╝╚════██║
 ██████╔╝██║   ██║██║     ██║   ██║   █████╗      ██╔╝
 ██╔═══╝ ██║   ██║██║     ██║   ██║   ██╔══╝     ██╔╝
 ██║     ╚██████╔╝╚██████╗╚██████╔╝   ██║        ██║
 ╚═╝      ╚═════╝  ╚═════╝ ╚═════╝    ╚═╝        ╚═╝
EOF
echo -e "${RESET}"
echo -e "                      ${BOLD}Author: Raphael 8s_G4${RESET}\n"
hr "$DIM"
echo ""

# The perfectly structured clone_repo function
clone_repo() {
    local NAME="$1"
    local DIR="$2"
    local URL="$3"
    local BRANCH="$4"

    echo -e "  📦  ${BOLD}${NAME}${RESET}"
    echo -e "      ${DIM}Path  :${RESET} ${BWHITE}${DIR}${RESET}"
    echo -e "      ${DIM}Remote:${RESET} ${DIM}${URL}${RESET}"
    [ -n "$BRANCH" ] && echo -e "      ${DIM}Branch:${RESET} ${CYAN}${BRANCH}${RESET}"
    echo ""

    if [ -d "$DIR" ]; then
        echo -e "  ${BGREEN}   ✔  Already present — skipping clone${RESET}"
        SKIPPED_COUNT=$(( SKIPPED_COUNT + 1 ))
    else
        echo -e "  ${BYELLOW}   ⬇  Not found locally — initiating clone…${RESET}"
        echo ""

        if [ -n "$BRANCH" ]; then
            git clone -b "$BRANCH" "$URL" "$DIR"
        else
            git clone "$URL" "$DIR"
        fi

        if [ $? -eq 0 ]; then
            echo -e "  ${BGREEN}   ✔  ${NAME} — cloned successfully ✨${RESET}"
            CLONED_COUNT=$(( CLONED_COUNT + 1 ))
        else
            echo -e "  ${BRED}   ✘  ${NAME} — clone FAILED${RESET}"
            FAILED=1
        fi
    fi
    echo ""
    hr "$DIM"
    echo ""
}

# Executing clones (Format: "NAME" "PATH" "URL" "BRANCH")
clone_repo "Bcr Tree" "vendor/bcr" "https://github.com/xiaomi-sm8750-onyx/android_vendor_bcr.git" "lineage-23.2"
clone_repo "Gcam Tree" "vendor/mgc" "https://gitlab.com/xiaomi-sm8750-onyx/android_vendor_mgc.git" "lineage-23.2"
clone_repo "Hardware Tree" "hardware/xiaomi" "https://github.com/pialgigabyte-source/android_hardware_xiaomi.git" "lineage-23.2"
clone_repo "Kernel Tree" "device/xiaomi/onyx-kernel" "https://github.com/xiaomi-sm8750-onyx/android_device_xiaomi_onyx-kernel.git" "lineage-23.2"
clone_repo "Vendor Tree" "vendor/xiaomi/onyx" "https://github.com/pialgigabyte-source/android_vendor_xiaomi_onyx.git" "16.2"

# Summary & Output
echo -e "  ${BOLD}Setup Summary:${RESET}"
echo -e "  ${BGREEN}Cloned successfully: ${CLONED_COUNT}${RESET} | ${BYELLOW}Skipped: ${SKIPPED_COUNT}${RESET}"

if [ "$FAILED" -eq 1 ]; then
    echo -e "\n  ${BRED}⚠️  Warning: Some repositories failed to clone. Please check the terminal logs above.${RESET}\n"
else
    echo -e "\n  ${BGREEN}🎉 vendorsetup.sh execution complete. Ready to build! 🚀${RESET}\n"
fi
