# Makefile for vim-vspec

REPOS_TYPE := vim-script
INSTALLATION_DIR := $(HOME)/.vim
TARGETS_STATIC = $(filter-out t/%,$(filter %.vim %.txt,$(all_files_in_repos)))
TARGETS_ARCHIVED = $(all_files_in_repos) mduem/Makefile
DEP_vim_vspec_URI := $(PWD)
DEP_vim_vspec_VERSION := HEAD




include mduem/Makefile

# __END__
