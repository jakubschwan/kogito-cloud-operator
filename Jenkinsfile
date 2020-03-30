pipeline {
    agent { label 'go'}
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
        timeout(time: 10, unit: 'MINUTES')
    }
    environment {
        
        WORKING_DIR = "/home/jenkins/go/src/github.com/kiegroup/kogito-cloud-operator/"
        GOPATH = "/home/jenkins/go"
        GOCACHE = "/home/jenkins/go/.cache/go-build"
    }
    stages {
        stage('Clean Workspace') {
            steps {
                dir ("${WORKING_DIR}") {
                    deleteDir()
                }
            }
        }
        stage('Initialize') {
            steps {
                println "do init"
                //sh "mkdir -p ${WORKING_DIR} && cd ${WORKSPACE} && cp -Rap * ${WORKING_DIR}"
                //sh "set +x && oc login --token=\$(oc whoami -t) --server=${OPENSHIFT_API} --insecure-skip-tls-verify"
            }
        }
        stage('debug config of full testing trigger') {
            steps {
                dir ("${WORKING_DIR}") {
                    script {
                        println "${currentBuild.buildCauses}"  // -- to get all causes of the build


                        // Get all Causes for the current build
                        def causes = currentBuild.getBuildCauses()

                        println "All causes: "+ causes

                        // Get a specific Cause type if present.
                        def specificCause = currentBuild.getBuildCauses('com.adobe.jenkins.github_pr_comment_build.GitHubPullRequestCommentCause')
                        println "Specific cause: " + specificCause

                        def pullRequestCommentCause = currentBuild.rawBuild.getCause(com.adobe.jenkins.github_pr_comment_build.GitHubPullRequestCommentCause)
                        println "PR Comment cause obj " + pullRequestCommentCause
                        
                        if (!specificCause.isEmpty()) {
                            println specificCause.properties
                            println specificCause.getCommentUrl()
                        } else {
                            println "Not triggered by rebuild comment"
                        }


                        //def isStartedByUser = currentBuild.rawBuild.getCause(UserIdCause) != null
                        //def pullRequestComment = currentBuild.rawBuild.getCause(hudson.model.Cause$GitHubPullRequestCommentCause)
                        //this does not work because of https://issues.jenkins-ci.org/browse/JENKINS-28178
                        //GitHubPullRequestCommentCause
                        // https://github.com/jenkinsci/github-pr-comment-build-plugin/blob/master/src/main/java/com/adobe/jenkins/github_pr_comment_build/GitHubPullRequestCommentCause.java

                        //println pullRequestComment
                        println "Continue for now"

                    }
                }
            }
        }
        stage('debug Smoke Testing') {
            steps {
                dir ("${WORKING_DIR}") {
                    script { 
                        echo "running smoke tests"
                        echo "more smoke tests..."
                    }
                }
            }
        }
        stage('debug Full tests') {
            steps {
                dir ("${WORKING_DIR}") {
                    script { 
                        echo "running full tests"
                    }
                }
            }

        }

    }
}