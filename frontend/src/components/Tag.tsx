import './Tag.css';

interface TagProps {
  children: React.ReactNode;
  variant?: 'default' | 'orange' | 'blue' | 'teal' | 'yellow' | 'red';
  size?: 'small' | 'medium';
}

export const Tag = ({ children, variant = 'default', size = 'small' }: TagProps) => {
  return (
    <span className={`tag tag--${variant} tag--${size}`}>
      {children}
    </span>
  );
};
