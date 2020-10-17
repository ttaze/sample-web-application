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
        
      


                    
              stage('build')
                {
              steps{
                  script{
		 sh 'cp -r /var/jenkins_home/workspace/maven-sonar-ansible-k8s@2/target .'
			  
		 def img = stage('Build') {
			 sh 'docker build . -t deekshithsn/devops-training:$Docker_tag'
			 sh ' docker tag deekshithsn/devops-training:$Docker_tag 192.168.30.131:8123/deekshithsn/devops-training:$Docker_tag'
		 }	  
                  
		 docker.withRegistry('http://192.168.30.131:8123', 'nexus') {
				    
			sh 'docker push 192.168.30.131:8123/deekshithsn/devops-training:$Docker_tag'
				
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
