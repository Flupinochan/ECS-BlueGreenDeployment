# ★Caution
# It costs quite a bit of money, so please remove it as soon as you are done verifying it!
## https://youtu.be/kzygrdNEGPs?si=-ho-VYZ8pINzpufA

0. Create an IAM Role to create the stack in CloudFormation<br>
   If you put an AdministratorAccess policy on it, there is no problem
1. Create a CloudFormation Stack named `[VPC-Stack]` from `[1VPC-CloudFormation.yml]`
2. Create a CloudFormation Stack named `[SG-Stack]` from `[2SG-CloudFormation.yml]`
3. Create a CloudFormation Stack named `[RDS-Stack]` from `[3RDS-CloudFormation.yml]`
4. Create a CloudFormation Stack named `[EFS-Stack]` from `[4EFS-CloudFormation.yml]`
5. Upload wordpress contents to EFS<br>
    ※Please refer to the `[UploadWordpressToEFS.txt]` manual
6. Create a CloudFormation Stack named `[ECR-CodeCommitBuild-Stack]` from `[5ECR-CodeCommitBuild-CloudFormation.yml]`
7. Upload code to CodeCommit<br>
    ※Please refer to the `[UploadCodeToCodeCommit.txt]` manual
8. Create a ECS Images<br>
    ※In the AWS Management Console (CodeBuild), select the `[wordpress-codebuild]` project and run build to create the ECS image
9. Create a CloudFormation Stack named `[ALB-Stack]` from `[6ALB-CloudFormation.yml]`
10. Create a CloudFormation Stack named `[ECS-Stack]` from `[7ECS-CloudFormation.yml]`<br>
★Caution<br>
    Initial ECS Cluster creation always fails<br>
    Delete the CloudFormation Stack named `[ECS-Stack]` and re-create it
11. After building the ECS, you will be able to access wordpress. Try accessing the ALB DNS name
12. Create a CloudFormation Stack named `[CodePipeline-Stack]` from `[8CodePipeline-CloudFormation.yml]`<br>
    Blue/Green Deployment is executed<br>
    Look at CodePipeline, number of ECS tasks, target groups, ECS Exec, etc
13. Delete the CloudFormation Stacks in the reverse order in which they were created<br>
★Caution<br>
    Deleting `[ECS-Stack]` will always fail<br>
    ECS Cluster should be ignored and `[ECS-Stack]` should be deleted with the retain attribute<br>
    After removing `[ALB-Stack]`, please manually remove ECS Cluster<br>
    The reason is that there are container instances in ECS Cluster<br>
    and ECS Cluster cannot be deleted until after `[ALB-Stack]` is deleted.
![Flowchart](https://github.com/Flupinochan/ECS-BlueGreenDeployment/assets/140839406/abbbb6a7-1565-4609-a620-80240a335d90)