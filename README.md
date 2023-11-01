# ★Caution
# It costs quite a bit of money, so please remove it as soon as you are done verifying it!

## https://youtu.be/kzygrdNEGPs?si=-ho-VYZ8pINzpufA

0. Create an IAM Role to create the stack in CloudFormation<br>
   If you put an AdministratorAccess policy on it, there is no problem
1. Create a CloudFormation Stack named [VPC-Stack]
2. Create a CloudFormation Stack named [SG-Stack]
3. Create a CloudFormation Stack named [RDS-Stack]
4. Create a CloudFormation Stack named [EFS-Stack]
5. Upload wordpress contents to EFS<br>
    ※Please refer to the [UploadWordpressToEFS.txt] manual
6. Create a CloudFormation Stack named [ECR-CodeCommitBuild-Stack]
7. Upload code to CodeCommit<br>
    ※Please refer to the [UploadCodeToCodeCommit.txt] manual
8. Create a ECS Images
    ※In the AWS Management Console (CodeBuild), select the [wordpress-codebuild] project and run build to create the ECS image
9. Create a CloudFormation Stack named [ALB-Stack]
10. Create a CloudFormation Stack named [ECS-Stack]<br>
★Caution<br>
    Initial ECS Cluster creation always fails<br>
    Delete the CloudFormation Stack named [ECS-Stack] and re-create it
11. After building the ECS, you will be able to access wordpress. Try accessing the ALB DNS name
12. Create a CloudFormation Stack named [CodePipeline-Stack]<br>
    Blue/Green Deployment is executed<br>
    Look at CodePipeline, number of ECS tasks, target groups, etc
13. Delete the CloudFormation Stacks in the reverse order in which they were created<br>
★Caution<br>
    Deleting ECS-Stack will always fail<br>
    ECS Cluster should be ignored and [ECS-Stack] should be deleted with the retain attribute<br>
    After removing ALB-Stack, please manually remove ECS Cluster<br>
    The reason is that there are container instances in ECS Cluster<br>
    and ECS Cluster cannot be deleted until after [ALB-Stack] is deleted.
