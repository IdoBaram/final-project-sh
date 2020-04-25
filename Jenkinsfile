node("linux") {
def customImage = ""
stage('Clone sources') {
        git url: 'https://github.com/IdoBaram/crud-application-using-flask-and-mysql.git'
}
// stage("build docker") {
// customImage = 
// docker.build("idobaram/crud-app" + ":latest") 
// }
stage('remove old images') {
    sh "docker system prune --all"
    // sh "docker rm -vf \$(docker ps -a -q)"
    }
script {
    withDockerRegistry( [credentialsId: 'dockerhub', url: ''] ) {
    def app = docker.build("idobaram/crud-app","-f ${env.WORKSPACE}/Dockerfile-app .")
    def db = docker.build("idobaram/crud-app-mysql:latest","-f ${env.WORKSPACE}/Dockerfile-mysql .")
    app.push()
    db.push()
}
}
stage("verify dockers") {
sh "docker images"
}
// stage("register image") {
// withDockerRegistry( [credentialsId: 'dockerhub', url: ''] ) {
//     def app.push()
//     def db.push()
// }
// }
stage("deploy crud-app") {
    sh "aws eks --region us-east-1 update-kubeconfig --name final_course_eks"
    sh "chmod +x ./*"
    sh "chmod +x ./*/*"
    sh "chmod +x ./*/*/*"
    sh "kubectl delete svc/crud-app deployment/crud-app"
    sh "kubectl apply -f ./services.yaml"
    sh "kubectl apply -f ./deployment.yaml"
    sh "kubectl get svc -o wide"
}
} 