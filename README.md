# ★Caution
# It costs quite a bit of money, so please remove it as soon as you are done verifying it!

## https://youtu.be/kzygrdNEGPs?si=-ho-VYZ8pINzpufA

0. Create an IAM Role to create the stack in CloudFormation<br>
   If you put an AdministratorAccess policy on it, there is no problem
1. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[VPC-Stack]</span> from <span style="color: rgb(0,255,255);">[1VPC-CloudFormation.yml]</span>
2. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[SG-Stack]</span> from <span style="color: rgb(0,255,255);">[2SG-CloudFormation.yml]</span>
3. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[RDS-Stack]</span> from <span style="color: rgb(0,255,255);">[3RDS-CloudFormation.yml]</span>
4. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[EFS-Stack]</span> from <span style="color: rgb(0,255,255);">[4EFS-CloudFormation.yml]</span>
5. Upload wordpress contents to EFS<br>
    ※Please refer to the <span style="color: rgb(0,255,255);">[UploadWordpressToEFS.txt]</span> manual
6. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[ECR-CodeCommitBuild-Stack]</span> from <span style="color: rgb(0,255,255);">[5ECR-CodeCommitBuild-CloudFormation.yml]</span>
7. Upload code to CodeCommit<br>
    ※Please refer to the <span style="color: rgb(0,255,255);">[UploadCodeToCodeCommit.txt]</span> manual
8. Create a ECS Images<br>
    ※In the AWS Management Console (CodeBuild), select the <span style="color: rgb(0,255,255);">[wordpress-codebuild]</span> project and run build to create the ECS image
9. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[ALB-Stack]</span> from <span style="color: rgb(0,255,255);">[6ALB-CloudFormation.yml]</span>
10. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[ECS-Stack]</span> from <span style="color: rgb(0,255,255);">[7ECS-CloudFormation.yml]</span><br>
<span style="color: rgb(255,0,255);">★Caution</span><br>
    Initial ECS Cluster creation always fails<br>
    Delete the CloudFormation Stack named <span style="color: rgb(0,255,255);">[ECS-Stack]</span> and re-create it
11. After building the ECS, you will be able to access wordpress. Try accessing the ALB DNS name
12. Create a CloudFormation Stack named <span style="color: rgb(0,255,255);">[CodePipeline-Stack]</span> from <span style="color: rgb(0,255,255);">[8CodePipeline-CloudFormation.yml]</span><br>
    Blue/Green Deployment is executed<br>
    Look at CodePipeline, number of ECS tasks, target groups, ECS Exec, etc
13. Delete the CloudFormation Stacks in the reverse order in which they were created<br>
<span style="color: rgb(255,0,255);">★Caution</span><br>
    Deleting <span style="color: rgb(0,255,255);">[ECS-Stack]</span> will always fail<br>
    ECS Cluster should be ignored and <span style="color: rgb(0,255,255);">[ECS-Stack]</span> should be deleted with the retain attribute<br>
    After removing <span style="color: rgb(0,255,255);">[ALB-Stack]</span>, please manually remove ECS Cluster<br>
    The reason is that there are container instances in ECS Cluster<br>
    and ECS Cluster cannot be deleted until after <span style="color: rgb(0,255,255);">[ALB-Stack]</span> is deleted.

![Flowchart](https://github.com/Flupinochan/ECS-BlueGreenDeployment/assets/140839406/abbbb6a7-1565-4609-a620-80240a335d90)
