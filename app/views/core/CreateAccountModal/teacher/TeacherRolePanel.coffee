forms = require 'core/forms'

TeacherRolePanel = Vue.extend
  name: 'teacher-role-panel'
  template: require('templates/core/create-account-modal/teacher-role-panel')()
  data: ->
    formData = _.pick(@$store.state.modal.trialRequestProperties, [
      'phoneNumber'
      'role'
      'purchaserRole'
    ])
    return _.assign(formData, {
      showRequired: false
    })

  computed: {
    validPhoneNumber: ->
      return forms.validatePhoneNumber(@phoneNumber)
  }
  methods:
    clickContinue: ->
      # Make sure to add conditions if we change this to be used on non-teacher path
      window.tracker?.trackEvent 'CreateAccountModal Teacher TeacherRolePanel Continue Clicked', category: 'Teachers'
      attrs = _.pick(@, 'phoneNumber', 'role', 'purchaserRole')
      unless _.all(attrs) and @validPhoneNumber
        @showRequired = true
        return
      @commitValues()
      window.tracker?.trackEvent 'CreateAccountModal Teacher TeacherRolePanel Continue Success', category: 'Teachers'
      @$emit('continue')
      
    clickBack: ->
      @commitValues()
      window.tracker?.trackEvent 'CreateAccountModal Teacher TeacherRolePanel Back Clicked', category: 'Teachers'
      @$emit('back')

    commitValues: ->
      attrs = _.pick(@, 'phoneNumber', 'role', 'purchaserRole')
      @$store.commit('modal/updateTrialRequestProperties', attrs)

  mounted: ->
    @$refs.focus.focus()

module.exports = TeacherRolePanel
