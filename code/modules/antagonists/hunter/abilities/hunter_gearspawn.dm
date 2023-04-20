/datum/targetable/hunter/hunter_gearspawn
	name = "Order hunting gear"
	desc = "Equip your hunting gear."
	icon_state = "gearspawn"
	targeted = FALSE
	target_nodamage_check = 0
	max_range = 0
	cooldown = 0
	pointCost = 0
	incapacitation_restriction = 1
	can_cast_while_cuffed = TRUE
	hunter_only = 0

	cast(mob/target)
		if (!holder)
			return 1

		var/mob/living/M = holder.owner

		if (!M || !ishuman(M))
			return 1

		actions.start(new/datum/action/bar/private/icon/hunter_transform(src), M)
		return 0

/datum/action/bar/private/icon/hunter_transform
	duration = 50
	interrupt_flags = INTERRUPT_MOVE | INTERRUPT_ACT | INTERRUPT_ACTION
	id = "hunter_transform"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "grabbed"
	var/datum/targetable/hunter/hunter_gearspawn/transform

	New(Transform)
		transform = Transform
		..()

	onStart()
		..()

		var/mob/living/M = owner

		if (M == null || !ishuman(M) || !isalive(M) || M.getStatusDuration("paralysis") > 0 || !transform)
			interrupt(INTERRUPT_ALWAYS)
			return

		boutput(M, "<span class='alert'><B>Request acknowledged. You must stand still.</B></span>")

	onUpdate()
		..()

		var/mob/living/M = owner

		if (M == null || !ishuman(M) || !isalive(M) || M.getStatusDuration("paralysis") > 0 || !transform)
			interrupt(INTERRUPT_ALWAYS)
			return

	onEnd()
		..()

		var/mob/living/carbon/human/M = owner
		M.hunter_transform()

	onInterrupt()
		..()

		var/mob/living/M = owner
		boutput(M, "<span class='alert'>You were interrupted!</span>")
