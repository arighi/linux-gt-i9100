#ifndef _ASM_ARM_IDLE_H
#define _ASM_ARM_IDLE_H

enum {
	IDLE_START = 1,
	IDLE_END,
};

struct notifier_block;

void idle_notifier_register(struct notifier_block *n);
void idle_notifier_unregister(struct notifier_block *n);

#endif /* _ASM_ARM_IDLE_H */
