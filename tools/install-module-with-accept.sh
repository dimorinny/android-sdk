for module in "$@"
do
    echo "y" | android update sdk --filter $module --no-ui --force -a
done
