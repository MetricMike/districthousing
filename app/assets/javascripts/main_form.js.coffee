# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
if window.location.pathname.match(/\/apply$/)
	$ ->

		changeSection = (e, noscroll)->
			hash = window.location.hash
			sectionId = hash.substring 1
			$('.section').each ()->
				section = $ @
				if section.attr('id') is sectionId
					section.toggleClass 'hide', false
				else
					section.toggleClass 'hide', true
			$('.wizard-nav a').each ()->
				link = $ @
				parent = link.parent()
				if link.attr('href') is hash
					parent.toggleClass 'active', true
				else
					parent.toggleClass 'active', false
			window.scrollTo 0, 0 unless noscroll

		$(window).on 'hashchange', changeSection

		showDownloadWarning = ->
			$('#download-warning').modal()

		submitUpdateForm = ->
			$('#update-button').submit()

		initialize = (e)->
			$('.download-forms').click(
				showDownloadWarning
				submitUpdateForm
			)
			firstSectionHash = $('.wizard-nav a').eq(0).attr 'href'
			if window.location.hash.length <= 1
				window.location.hash = firstSectionHash
			else
				changeSection null, !!e

		$(document).ajaxComplete initialize
		initialize()
