# Commented code will be addressed by further enhancements:
# https://issues.redhat.com/browse/KOGITO-1699
# https://issues.redhat.com/browse/KOGITO-1700
# https://issues.redhat.com/browse/KOGITO-1701

@performance
Feature: Kogito Service Performance

  Background:
    Given Namespace is created

  @quarkus
  Scenario Outline: Quarkus Kogito Service Performance without persistence
    Given Kogito Operator is deployed
    And Deploy quarkus example service "jbpm-quarkus-example" with native <native>
    And Kogito application "jbpm-quarkus-example" has 1 pods running within <minutes> minutes
    And HTTP GET request on service "jbpm-quarkus-example" with path "orders" is successful within 3 minutes

    When <requests> HTTP POST requests with report using 100 threads on service "jbpm-quarkus-example" with path "orders" and body:
      """json
      {
        "approver" : "john",
        "order" : {
          "orderNumber" : "12345",
          "shipped" : false
        }
      }
      """

    Then HTTP GET request on service "jbpm-quarkus-example" with path "orders" should return an array of size <requests> within 1 minutes
    And HTTP GET request on service "jbpm-quarkus-example" with path "orderItems" should return an array of size <requests> within 1 minutes
    #And All human tasks on path "orderItems" with path task name "Verify_order" are successfully "completed" with timing "true"


    Examples: Non Native
      | native   | minutes | requests |
      | disabled | 10      | 40000    |
      | disabled | 10      | 80000    |
#      | disabled | 10      | 160000   |
#      | disabled | 10      | 320000   |

    @native
    Examples: Native
      | native  | minutes | requests |
      | enabled | 20      | 40000    |
      | enabled | 20      | 80000    |
#      | enabled | 20      | 160000   |
#      | enabled | 20      | 320000   |

#####

  @quarkus
  @persistence
  Scenario Outline: Quarkus Kogito Service Performance with persistence
    Given Kogito Operator is deployed with Infinispan operator
    And Deploy quarkus example service "jbpm-quarkus-example" with native <native> and persistence
    And Kogito application "jbpm-quarkus-example" has 1 pods running within <minutes> minutes
    And HTTP GET request on service "jbpm-quarkus-example" with path "orders" is successful within 3 minutes

    When <requests> HTTP POST requests with report using 100 threads on service "jbpm-quarkus-example" with path "orders" and body:
      """json
      {
        "approver" : "john",
        "order" : {
          "orderNumber" : "12345",
          "shipped" : false
        }
      }
      """

    Then HTTP GET request on service "jbpm-quarkus-example" with path "orders" should return an array of size <requests> within 1 minutes
    And HTTP GET request on service "jbpm-quarkus-example" with path "orderItems" should return an array of size <requests> within 1 minutes
    #And All human tasks on path "orderItems" with path task name "Verify_order" are successfully "completed" with timing "true"


    Examples: Non Native
      | native   | minutes | requests |
      | disabled | 10      | 40000    |
      | disabled | 10      | 80000    |
#      | disabled | 10      | 160000   |
#      | disabled | 10      | 320000   |

    @native
    Examples: Native
      | native  | minutes | requests |
      | enabled | 20      | 40000    |
      | enabled | 20      | 80000    |
#      | enabled | 20      | 160000   |
#      | enabled | 20      | 320000   |

#####

  @springboot
  Scenario Outline: Spring Boot Kogito Service Performance without persistence
    Given Kogito Operator is deployed
    And Deploy spring boot example service "jbpm-springboot-example"
    And Kogito application "jbpm-springboot-example" has 1 pods running within <minutes> minutes
    And HTTP GET request on service "jbpm-springboot-example" with path "orders" is successful within 3 minutes

    When <requests> HTTP POST requests with report using 100 threads on service "jbpm-springboot-example" with path "orders" and body:
      """json
      {
        "approver" : "john",
        "order" : {
          "orderNumber" : "12345",
          "shipped" : false
        }
      }
      """

    Then HTTP GET request on service "jbpm-springboot-example" with path "orders" should return an array of size <requests> within 1 minutes
    And HTTP GET request on service "jbpm-springboot-example" with path "orderItems" should return an array of size <requests> within 1 minutes
    #And All human tasks on path "orderItems" with path task name "Verify_order" are successfully "completed" with timing "true"

    Examples:
      | minutes | requests |
      | 10      | 40000    |
      | 10      | 80000    |
#      | 10      | 160000   |
#      | 10      | 320000   |

#####

  @springboot
  @persistence
  Scenario Outline: Spring Boot Kogito Service Performance with persistence
    Given Kogito Operator is deployed with Infinispan operator
    And Deploy spring boot example service "jbpm-springboot-example" with persistence
    And Kogito application "jbpm-springboot-example" has 1 pods running within <minutes> minutes
    And HTTP GET request on service "jbpm-springboot-example" with path "orders" is successful within 3 minutes

    When <requests> HTTP POST requests with report using 100 threads on service "jbpm-springboot-example" with path "orders" and body:
      """json
      {
        "approver" : "john",
        "order" : {
          "orderNumber" : "12345",
          "shipped" : false
        }
      }
      """

    Then HTTP GET request on service "jbpm-springboot-example" with path "orders" should return an array of size <requests> within 1 minutes
    And HTTP GET request on service "jbpm-springboot-example" with path "orderItems" should return an array of size <requests> within 1 minutes
    #And All human tasks on path "orderItems" with path task name "Verify_order" are successfully "completed" with timing "true"

    Examples:
      | minutes | requests |
      | 10      | 40000    |
      | 10      | 80000    |
#      | 10      | 160000   |
#      | 10      | 320000   |
