node("linux") {
def customImage = ""
stage('Clone sources') {
        git url: 'https://github.com/IdoBaram/crud-application-using-flask-and-mysql.git'
}
stage('remove old images') {
    sh "docker system prune --all"
    }
script('build and register image') {
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
stage("deploy crud-app to k8s") {
    sh "aws eks --region us-east-1 update-kubeconfig --name final_course_eks"
    sh "chmod +x ./*"
    sh "chmod +x ./*/*"
    sh "chmod +x ./*/*/*"
    sh "kubectl delete svc/crud-app deployment/crud-app"
    sh "kubectl apply -f ./services.yaml"
    sh "kubectl apply -f ./deployment.yaml"
    sh "kubectl apply -f ./mysql_deploy.yaml"
    sh "kubectl apply -f ./mysql_svc.yaml"
    sh "kubectl get svc -o wide"
}
} 