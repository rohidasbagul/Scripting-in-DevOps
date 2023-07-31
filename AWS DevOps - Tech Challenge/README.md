[Challenge #1  - Use AWS cloud]

["A 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these resources on a cloud environment (Azure/AWS/GCP). Please remember we will not be judged on the outcome but more focusing on the approach, style and reproducibility."]

-----------------------------------------------------Challenge #1  - Use AWS cloud------------------------------------------------------

Typically, in a 3-tier environment using Terraform, we define the infrastructure for the following layers:

1. Presentation Layer: This tier includes resources for the frontend applications or web servers that users interact with, such as load balancers and virtual machines.
2. Application Layer: This tier contains resources for the backend application servers that handle business logic, such as application servers and containers.
3. Data Layer: This tier comprises resources for the database servers or storage services, where the application data is stored and retrieved.

The terraform code(i.e final-main.tf, final-variables.tf) does the following:

1. Creates a VPC with the CIDR block provided in the region you want.
2. Creates subnets for each layer.
3. Creates an IGW and NAT gateway.
4. Creates Route tables.
5. Creates a RDS instance.
6. Configures security group for Web layer.
7. EC2 instances for webservers.
8. Application load balancer.

--------------------------------------------------------------------------------------------------

[Challenge #2]  

["We need to write code that will query the meta data of an instance within AWS or Azure or GCP and provide a json formatted output. The choice of language and implementation is up to you."]

The Bash script code(i.e ec2-instance-metadata.sh) does the following:

1. The script defines a function called ["get_ec2_metadata"] that retrieves the EC2 instance metadata using the instance ID obtained from the EC2 instance metadata service and the AWS CLI's describe-instances command.
2. The script checks if the AWS CLI is installed using the command -v command. If the AWS CLI is not found, it displays an error message and exits with an error code.
3. It then calls the ["get_ec2_metadata"] function to retrieve the instance metadata and stores it in the variable ["INSTANCE_METADATA_JSON"].
4. If the instance metadata is successfully retrieved, it is printed in JSON format using the echo command.
5. If there is an issue with retrieving the metadata (e.g., if the script is not running on an EC2 instance), an error message is displayed, and the script exits with an error code.
Remember to make the script executable using the chmod +x script_name.sh command before running it.


--------------------------------------------------------END-------------------------------------------
