#NOTE: This script must be run as sudo or su
#NOTE: This script uses the apt-get package manager, which is standard on ubuntu
#NOTE: This script assumes Alfresco Root is passed as a parameter
#NOTE: Ensure that EisenVault base customisations have already been installed


alfresco_dir=$1
echo "Installing to $alfresco_dir"

rm $alfresco_dir/amps/*
rm $alfresco_dir/amps_share/*

#step 1 - stop alfresco
$alfresco_dir/alfresco.sh stop


#step 2 copy and apply AMP file with Alfresco code changes

cp ../amps_share/* $alfresco_dir/amps_share/
cp ../amps/* $alfresco_dir/amps/

$alfresco_dir/bin/apply_amps.sh -force -verbose

#step 3 - start alfresco
echo "Trying to start alfresco"
$alfresco_dir/alfresco.sh start

#Wait till share amp has been deployed
while [ ! -d "$alfresco_dir/tomcat/webapps/share/WEB-INF/lib" ] 
do
	#Sleep for 20 seconds
	sleep 20
done

