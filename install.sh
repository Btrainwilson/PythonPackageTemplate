SCRIPTDIR="$(realpath "$(dirname "$0")")"
# Rename package_dir to the name of the package
mv ./package_dir $1

# Push package name to Makefile
sed -i "s/PACKAGE_NAME/$1/g" Makefile

# Push package name to readme
sed -i "s/\$project/$1/g" README.rst

