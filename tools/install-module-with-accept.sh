for module in "$@"
do
    echo "y" | android update sdk --all --no-ui --filter $module
done
