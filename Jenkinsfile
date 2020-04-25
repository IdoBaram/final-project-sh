node("linux") {
def customImage = ""
stage('Clone sources') {
        git url: 'https://github.com/IdoBaram/crud-application-using-flask-and-mysql.git'
}
stage("build docker") {
customImage = 
docker.build("idobaram/mid-course-app" + ":$BUILD_NUMBER") 
}
stage("verify dockers") {
sh "docker images"
}
stage("register image") {
withDockerRegistry( [credentialsId: 'dockerhub', url: ''] ) {
    customImage.push()
}
}
stage("deploy crud-app") {
    sh "aws eks --region us-east-1 update-kubeconfig --name mid_course_eks"
    sh "kubectl apply -f ./services.yaml"
}
} 