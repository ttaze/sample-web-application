currentBuild.displayName = "Final_Demo # "+currentBuild.number

 def registryProjet='deekshithsn/devops-training'

   def getDockerTag(){
        def tag = sh script: 'git rev-parse HEAD', returnStdout: true
        return tag
        }
        

pipeline{
        agent any  
        environment{
	    Docker_tag = getDockerTag()
        }
        
        stages{


              stage('Quality Gate Statuc Check'){

               agent {
                docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
                }
            }
                  steps{
                      script{
                      withSonarQubeEnv('sonar_server') { 
                      sh "mvn sonar:sonar"
                       }
                   
		    sh "mvn clean install"
                  }
                }  
              }


                    
              stage('build')
                {
              steps{
                  script{
		 sh 'cp -r /var/jenkins_home/workspace/maven-ansible-sonar-k8s@2/target .'
			  
		 def img = stage('Build') {
			 sh 'docker build . -t deekshithsn/devops-training:$Docker_tag'
			 sh ' docker tag deekshithsn/devops-training:$Docker_tag 192.168.32.131:8888/deekshithsn/devops-training:$Docker_tag'
		 }	  
                  
		 docker.withRegistry('http://192.168.32.131:8082', 'nexus') {
				    
			sh 'docker push 192.168.32.131:8082/deekshithsn/devops-training:$Docker_tag'
				
		 }
                       }
                    }
                 }
		 
		stage('ansible playbook'){
			steps{ 
				script{
				    sh '''final_tag=$(echo $Docker_tag | tr -d ' ')
				     echo ${final_tag}test
				     sed -i "s/docker_tag/$final_tag/g"  deployment.yaml
				     '''
			 	
				    ansiblePlaybook become: true, installation: 'ansible', inventory: 'hosts', playbook: 'ansible.yaml'
				
			}
			}}
		
	
		
               }
	       
	       
	       
	      
    
}
