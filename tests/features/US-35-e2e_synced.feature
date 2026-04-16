@azure.QAGTM-41
@app
@authentication
Feature: US-35 Autenticación y Acceso a la Plataforma
  Como visitante no autenticado
  Quiero navegar desde Home, autenticarme, y acceder a mi Dashboard
  Para poder acceder de forma segura a la plataforma con mis credenciales

  Background:
    Given I go to "home" page

  @azure.QAGTM-37
  @e2e @azure.cv.1.0.0
  @sanity @azure.link.parent_test_plan.QAGTM-18 @azure.link.parent_test_plan.QAGTM-20 @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC1,AC2,AC3,AC4
  Scenario: Flujo completo de autenticacion desde Home hasta Dashboard
    # AC1: Home carga correctamente con titulo, mensaje de bienvenida y enlace de login
    Then the element "welcome_message" is visible
    Then the element "login_link" is visible
    # AC2: Navegacion desde Home hacia Login funciona
    When I click the "login_link" element
    Then the "login" page is loaded
    # AC3: Formulario Login contiene todos los campos requeridos
    Then the element "email_input" is visible
    Then the element "password_input" is visible
    Then the element "submit_button" is visible
    Then the element "back_to_home" is visible
    # AC4: Login exitoso redirige al Dashboard y muestra datos del usuario
    When I type "test@legna.dev" in the "email_input" element
    When I type "EphemeralTest@2026" in the "password_input" element
    When I click the "submit_button" element
    Then the "dashboard" page is loaded
    Then the element "success_message" is visible
    Then the element "user_email" is visible

  @azure.QAGTM-38
  @e2e @azure.cv.1.0.0
  @smoke @azure.link.parent_test_plan.QAGTM-20 @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC5,AC6
  Scenario: Credenciales invalidas muestran mensaje de error apropiado
    When I click the "login_link" element
    Then the "login" page is loaded
    # AC5: Email no registrado es rechazado con mensaje de error
    When I type "wrong@email.com" in the "email_input" element
    When I type "EphemeralTest@2026" in the "password_input" element
    When I click the "submit_button" element
    Then the "login" page is loaded
    Then the element "submit_error" is visible
    # AC6: Contrasena incorrecta es rechazada con mensaje de error
    Given I go to "login" page
    When I type "test@legna.dev" in the "email_input" element
    When I type "WrongPassword123!" in the "password_input" element
    When I click the "submit_button" element
    Then the "login" page is loaded
    Then the element "submit_error" is visible

  @azure.QAGTM-39
  @e2e @azure.cv.1.0.0
  @regression @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC7,AC8,AC9
  Scenario: Validacion de campos requeridos impide envio con datos incompletos
    When I click the "login_link" element
    Then the "login" page is loaded
    # AC9: Ambos campos vacios muestran validacion en ambos campos
    When I click the "submit_button" element
    Then the element "email_error" is visible
    Then the element "password_error" is visible
    # AC8: Solo contrasena vacia muestra validacion en campo contrasena
    Given I go to "login" page
    When I type "test@legna.dev" in the "email_input" element
    When I click the "submit_button" element
    Then the element "password_error" is visible
    # AC7: Solo email vacio muestra validacion en campo email
    Given I go to "login" page
    When I type "EphemeralTest@2026" in the "password_input" element
    When I click the "submit_button" element
    Then the element "email_error" is visible

  @azure.QAGTM-40
  @e2e @azure.cv.1.0.0
  @regression @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC10
  Scenario: Navegacion desde Login de vuelta a Home funciona correctamente
    When I click the "login_link" element
    Then the "login" page is loaded
    # AC10: Enlace "Volver a Inicio" navega correctamente a Home
    When I click the "back_to_home" element
    Then the "home" page is loaded
    Then the element "welcome_message" is visible
    Then the element "login_link" is visible
